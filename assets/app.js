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
    
    // Fonction de sélection des membres
    const handleMemberSelection = () => {
        const members = document.querySelectorAll('.js-member');
        
        members.forEach(m => {
            m.addEventListener('click', () => {
                // On enlève la classe leader à tout le monde
                members.forEach(member => member.classList.remove('leader'));
                // On l'ajoute au membre cliqué
                m.classList.add('leader');
            });
        });
    };

    handleMemberSelection();
    console.log('Système de sélection de personnage actif ! 🕹️');
});
console.log('This log comes from assets/app.js - welcome to AssetMapper! 🎉');
/* ===================================== */
/* =============== EQUIPE FIN=========== */
/* ===================================== */

/* ===================================== */
/* =============== POPUP DEBUT========== */
/* ===================================== */

document.addEventListener('DOMContentLoaded', () => {
    // Popup functionality
    const popupOverlay2 = document.querySelector('.popup-overlay2');
    const closeBtn2 = document.querySelector('.close-btn2');
    const btnPopup = document.querySelector('#btn-popup');
    
    // Function to open popup (can be called from anywhere)
    window.openPopup2 = () => {
        if (popupOverlay2) {
            popupOverlay2.classList.add('visible');
        }
    };
    
    // Function to close popup
    window.closePopup2 = () => {
        if (popupOverlay2) {
            popupOverlay2.classList.remove('visible');
        }
    };
    
    // Open popup when clicking the button
    if (btnPopup) {
        btnPopup.addEventListener('click', () => {
            openPopup2();
        });
    }
    
    // Close popup when clicking the close button
    if (closeBtn2) {
        closeBtn2.addEventListener('click', () => {
            closePopup2();
        });
    }
    
    // Close popup when clicking outside the content
    if (popupOverlay2) {
        popupOverlay2.addEventListener('click', (e) => {
            if (e.target === popupOverlay2) {
                closePopup2();
            }
        });
    }
    
    console.log('Popup système actif ! 🕹️');
});

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