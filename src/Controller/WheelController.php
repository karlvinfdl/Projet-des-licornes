<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class WheelController extends AbstractController
{
    #[Route('/wheel', name: 'app_wheel')]
    public function index(): Response
    {
        return $this->render('wheel/index.html.twig', [
            'controller_name' => 'WheelController',
        ]);
    }
}
