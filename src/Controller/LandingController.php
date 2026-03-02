<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LandingController extends AbstractController
{
    #[Route('/landing', name: 'landing')]
    public function index(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            // récupérer les données
            $nom = $request->request->get('nom');
            $prenom = $request->request->get('prenom');
            $age = $request->request->get('age');
            $email = $request->request->get('email');
            $ville = $request->request->get('ville');

            // ici tu peux sauvegarder en base si tu veux

            return $this->redirectToRoute('fin');
        }

        return $this->render('landing/index.html.twig');
    }
}