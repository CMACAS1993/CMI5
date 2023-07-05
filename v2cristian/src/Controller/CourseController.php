<?php

namespace App\Controller;

use App\Entity\Course;
use App\Form\CourseType;
use App\Repository\CourseRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/course")
 */
class CourseController extends AbstractController
{
    /**
     * @Route("/", name="app_course_index", methods={"GET"})
     */
    public function index(CourseRepository $courseRepository): Response
    {
        return $this->render('course/index.html.twig', [
            'courses' => $courseRepository->findAll(),
        ]);
    }

    /**
     * @Route("/new", name="app_course_new", methods={"GET", "POST"})
     */
    function new (Request $request, CourseRepository $courseRepository): Response {
        $course = new Course();
        $form = $this->createForm(CourseType::class, $course);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $courseRepository->add($course);
            $this->addFlash("success", 'Insertado satisfactoriamente!!! ');
            return $this->redirectToRoute('app_course_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('course/new.html.twig', [
            'course' => $course,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="app_course_show", methods={"GET"})
     */
    public function show(Course $course): Response
    {
        return $this->render('course/show.html.twig', [
            'course' => $course,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_course_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Course $course, CourseRepository $courseRepository): Response
    {
        $form = $this->createForm(CourseType::class, $course);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $courseRepository->add($course);
            $this->addFlash('success', 'Datos actualizados satisfactoriamente !!!');
            return $this->redirectToRoute('app_course_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('course/edit.html.twig', [
            'course' => $course,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="app_course_delete", methods={"POST"})
     */
    public function delete(Request $request, Course $course, CourseRepository $courseRepository): Response
    {
        if (!$this->tieneMiembros($course) && !$this->asocCurso($course) && $this->isCsrfTokenValid('delete' . $course->getId(), $request->request->get('_token'))) {
            $courseRepository->remove($course);
            $this->addFlash('success', 'Datos eliminados satisfactoriamente !!!');
        } else {

            if ($this->asocCurso($course)) {
                $this->addFlash('error', 'Este curso está asociado a al menos una solución !!!');

            }
            if ($this->tieneMiembros($course)) {
                $this->addFlash('error', 'Este curso tiene miembros inscritos,revise !!!');

            }

        }

        return $this->redirectToRoute('app_course_index', [], Response::HTTP_SEE_OTHER);
    }

    public function asocCurso(Course $course)
    {
        $asociada = false;
        $em = $this->getDoctrine()->getManager();
        $interna = $em->getRepository('App:PClass')->findBy(array('course' => $course->getId()));
        $internaest = $em->getRepository('App:StudPClass')->findBy(array('course' => $course->getId()));
        $code = $em->getRepository('App:SuccessCode')->findBy(array('course' => $course->getId()));
        $codeest = $em->getRepository('App:EvalCode')->findBy(array('course' => $course->getId()));
        $diagram = $em->getRepository('App:ModelDiagramSuccess')->findBy(array('course' => $course->getId()));
        $diagramest = $em->getRepository('App:ModelDiagramTest')->findBy(array('course' => $course->getId()));

        if (!empty($interna) || !empty($internaest) || !empty($code) || !empty($codeest) || !empty($diagram) || !empty($diagramest)) {
            $asociada = true;
            return $asociada;
            $this->addFlash('error', 'Este curso está asociado a al menos una solución !!!');
        }

        return $asociada;

    }

    public function tieneMiembros(Course $course)
    {
        $miembros = false;
        $em = $this->getDoctrine()->getManager();

        if (count($course->getMembers()) > 0) {

            $miembros = true;
            return $miembros;
            $this->addFlash('error', 'Este curso tiene miembros inscritos,revise !!!');
        }

        return $miembros;

    }

}
