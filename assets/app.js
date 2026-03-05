import './stimulus_bootstrap.js';

/* ===================================== */
/* ============== LANDING DEBUT========= */
/* ===================================== */

/* ===================================== */
/* ============== LANDING FIN=========== */
/* ===================================== */

/* ===================================== */
/* =============== EQUIPE DEBUT========= */
/* ===================================== */

// Si tu décides de mettre la logique ici plutôt que dans le Twig :
document.addEventListener('DOMContentLoaded', () => {
    
    // Fonction de sélection des membres et mise à jour du lien
    const handleMemberSelection = () => {
        const members = document.querySelectorAll('.js-member5');
        const portfolioBtn = document.getElementById('link-portfolio');
        
        members.forEach(m => {
            m.addEventListener('click', () => {
                // 1. Mise à jour visuelle (taille et nom)
                members.forEach(member => member.classList.remove('leader5'));
                m.classList.add('leader5');

                // 2. Mise à jour du lien Portfolio
                const newUrl = m.getAttribute('data-portfolio');
                
                // On vérifie que le bouton existe et que l'URL n'est pas vide
                if (portfolioBtn && newUrl && newUrl.trim() !== "") {
                    portfolioBtn.href = newUrl;
                    console.log('Lien mis à jour pour : ' + m.getAttribute('data-name'));
                }
            });
        });
    };

    handleMemberSelection();
    console.log('Système de sélection de personnage prêt ! 🦄');
});

/* ===================================== */
/* =============== EQUIPE FIN=========== */
/* ===================================== */

/* ===================================== */
/* =============== POPUP DEBUT========== */
/* ===================================== */

/* ===================================== */
/* =============== POPUP FIN============ */
/* ===================================== */

/* ===================================== */
/* ================= FIN DEBUT========== */
/* ===================================== */

/* ===================================== */
/* ================= FIN FIN============ */
/* ===================================== */

/* ===================================== */
/* ===== RESPONSIVE DEBUT=============== */
/* ===================================== */

/* ===================================== */
/* ======= RESPONSIVE FIN=============== */
/* ===================================== */

console.log('This log comes from assets/app.js - welcome to AssetMapper! 🎉');