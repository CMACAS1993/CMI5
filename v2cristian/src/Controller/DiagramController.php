<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Knp\Bundle\SnappyBundle\Snappy\Response\PdfResponse;
use Knp\Bundle\SnappyBundle\Snappy\Response\JpegResponse;
use Knp\Snappy\Image;
use Knp\Snappy\Pdf;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


class DiagramController extends AbstractController
{
    /**
     * @Route("/diagram", name="app_diagram")
     */
    public function index(): Response
    {
        return $this->render('diagram/index.html.twig', [
            'controller_name' => 'DiagramController',
        ]);
    }
  /**
     * @Route("/exportDiagram", name="app_export_uml")
     */
    public function PdfAction(Pdf $pdf)
    {
 
        $html = $this->renderView('diagram/index.html.twig',array());
        
        $pdf->setOption('enable-javascript', true);
$pdf->setOption('javascript-delay', 5000);
$pdf->setOption('enable-smart-shrinking', true);
$pdf->setOption('no-stop-slow-scripts', true);
$pdf->setOption('no-background', true);

        $pdf->setTemporaryFolder('c:\xampp\htdocs\v2cristian\temp');
        return new PdfResponse(
            $pdf->getOutputFromHtml($html,
                array('lowquality' => false,
                    'print-media-type' => true,
                    'encoding' => 'utf-8',
                    'page-size' => 'A4',
                    'outline-depth' => 8,
                    'orientation' => 'Portrait',
                    'title' => 'Diagrama UML',
                    'header-right' => 'Pag. [page] de [toPage]',
                    'header-font-size' => 7,
                )),
            200,
            array(
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'attachment; filename="Diagrama UML.pdf"'
            )
        );
    }
 

}
