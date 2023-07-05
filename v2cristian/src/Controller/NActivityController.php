<?php

namespace App\Controller;

use App\Entity\NActivity;
use App\Entity\NTA;
use App\Form\NActivityType;
use App\Repository\NActivityRepository;
use Knp\Bundle\SnappyBundle\Snappy\Response\PdfResponse;
use Knp\Snappy\Pdf;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/n/activity")
 */
class NActivityController extends AbstractController
{
    /**
     * @Route("/", name="app_n_activity_index", methods={"GET"})
     */
    public function index(NActivityRepository $nActivityRepository): Response
    {
        return $this->render('n_activity/index.html.twig', [
            'n_activities' => $nActivityRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="app_n_activity_new", methods={"GET", "POST"})
     */
    function new (Request $request, NActivityRepository $nActivityRepository): Response {
        $nActivity = new NActivity();
        $form = $this->createForm(NActivityType::class, $nActivity);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            /** @var NTA $interactiva */
            $interactiva = $em->getRepository('App:NTA')->findBy(array('denomination' => 'Interactiva'));
            $nActivity->setNTA($interactiva[0]);
            $nActivityRepository->add($nActivity);
            $this->addFlash("success", 'Insertado satisfactoriamente!!! ');
            return $this->redirectToRoute('app_n_activity_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('n_activity/new.html.twig', [
            'n_activity' => $nActivity,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="app_n_activity_show", methods={"GET"})
     */
    public function show(NActivity $nActivity): Response
    {
        return $this->render('n_activity/show.html.twig', [
            'n_activity' => $nActivity,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_n_activity_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, NActivity $nActivity, NActivityRepository $nActivityRepository): Response
    {
        $form = $this->createForm(NActivityType::class, $nActivity);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            /** @var NTA $interactiva */
            $interactiva = $em->getRepository('App:NTA')->findBy(array('denomination' => 'Interactiva'));
            $nActivity->setNTA($interactiva[0]);
            $nActivityRepository->add($nActivity);
            $this->addFlash('success', 'Datos actualizados satisfactoriamente !!!');
            return $this->redirectToRoute('app_n_activity_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('n_activity/edit.html.twig', [
            'n_activity' => $nActivity,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="app_n_activity_delete", methods={"POST"})
     */
    public function delete(Request $request, NActivity $nActivity, NActivityRepository $nActivityRepository): Response
    {
        if (!$this->asocActividad($nActivity) && $this->isCsrfTokenValid('delete' . $nActivity->getId(), $request->request->get('_token'))) {
            $nActivityRepository->remove($nActivity);
            $this->addFlash('success', 'Datos eliminados satisfactoriamente !!!');
        } else {
            if ($this->asocActividad($nActivity)) {
                $this->addFlash('error', 'Esta actividad está asociada a al menos una solución !!!');
            }

        }

        return $this->redirectToRoute('app_n_activity_index', [], Response::HTTP_SEE_OTHER);
    }

    public function asocActividad(NActivity $activity)
    {
        $asociada = false;
        $em = $this->getDoctrine()->getManager();
        $interna = $em->getRepository('App:PClass')->findBy(array('nactivity' => $activity->getId()));
        $internaest = $em->getRepository('App:StudPClass')->findBy(array('nactivity' => $activity->getId()));
        $code = $em->getRepository('App:SuccessCode')->findBy(array('nactivity' => $activity->getId()));
        $codeest = $em->getRepository('App:EvalCode')->findBy(array('nactivity' => $activity->getId()));
        $diagram = $em->getRepository('App:ModelDiagramSuccess')->findBy(array('nactivity' => $activity->getId()));
        $diagramest = $em->getRepository('App:ModelDiagramTest')->findBy(array('nactivity' => $activity->getId()));

        if (!empty($interna) || !empty($internaest) || !empty($code) || !empty($codeest) || !empty($diagram) || !empty($diagramest)) {
            $asociada = true;
            return $asociada;
            $this->addFlash('error', 'Esta actividad está asociada a al menos una solución !!!');
        }

        return $asociada;

    }

    /**
     * @Route("pdf/activity/{id}", name="app_n_activity_pdf")
     */
    public function PdfActionNActivity(Pdf $pdf, NActivity $a)
    {
        $em = $this->getDoctrine()->getManager();
        $html = $this->renderView('pdf/show_nactivity.html.twig', array('a' => $a));
        $pdf->setTemporaryFolder('c:\xampp\htdocs\v2cristian\temp');
        return new PdfResponse(
            $pdf->getOutputFromHtml($html,
                array('lowquality' => false,
                    'print-media-type' => true,
                    'encoding' => 'utf-8',
                    'page-size' => 'A4',
                    'outline-depth' => 8,
                    'orientation' => 'Portrait',
                    'title' => 'Actividad',
                    'header-right' => 'Pag. [page] de [toPage]',
                    'header-font-size' => 7,
                )),
            200,
            array(
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'attachment; filename="actividad.pdf"',
            )
        );
    }

}
