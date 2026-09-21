/* =========================================================
   JÓVENES INFLUENCERS DEL SEÑOR
   APP.JS
========================================================= */


/* =========================================================
   AÑO AUTOMÁTICO
========================================================= */

const currentYear = document.getElementById("currentYear");

if (currentYear) {
    currentYear.textContent = new Date().getFullYear();
}


/* =========================================================
   MENÚ MÓVIL
========================================================= */

const menuToggle = document.getElementById("menuToggle");
const mainNav = document.getElementById("mainNav");

if (menuToggle && mainNav) {

    menuToggle.addEventListener("click", () => {

        mainNav.classList.toggle("open");

        const icon = menuToggle.querySelector("i");

        if (mainNav.classList.contains("open")) {

            icon.classList.remove("fa-bars");
            icon.classList.add("fa-xmark");

        } else {

            icon.classList.remove("fa-xmark");
            icon.classList.add("fa-bars");

        }

    });

}


/* =========================================================
   CERRAR MENÚ AL HACER CLICK
========================================================= */

const navLinks = document.querySelectorAll(".nav-link");

navLinks.forEach(link => {

    link.addEventListener("click", () => {

        if (mainNav) {
            mainNav.classList.remove("open");
        }

        if (menuToggle) {

            const icon =
                menuToggle.querySelector("i");

            if (icon) {

                icon.classList.remove("fa-xmark");
                icon.classList.add("fa-bars");

            }

        }

    });

});


/* =========================================================
   NAVEGACIÓN ACTIVA
========================================================= */

const sections = document.querySelectorAll(
    "main section[id]"
);

window.addEventListener("scroll", () => {

    let current = "";

    sections.forEach(section => {

        const sectionTop =
            section.offsetTop - 120;

        const sectionHeight =
            section.offsetHeight;

        if (
            window.scrollY >= sectionTop &&
            window.scrollY <
            sectionTop + sectionHeight
        ) {

            current =
                section.getAttribute("id");

        }

    });


    navLinks.forEach(link => {

        link.classList.remove("active");

        const href =
            link.getAttribute("href");

        if (href === `#${current}`) {

            link.classList.add("active");

        }

    });

});


/* =========================================================
   BUSCADOR
========================================================= */

const openSearch =
    document.getElementById("openSearch");

const closeSearch =
    document.getElementById("closeSearch");

const searchOverlay =
    document.getElementById("searchOverlay");

const searchInput =
    document.getElementById("searchInput");

const searchResults =
    document.getElementById("searchResults");


if (openSearch && searchOverlay) {

    openSearch.addEventListener("click", () => {

        searchOverlay.classList.add("open");

        setTimeout(() => {

            if (searchInput) {
                searchInput.focus();
            }

        }, 100);

    });

}


if (closeSearch && searchOverlay) {

    closeSearch.addEventListener("click", () => {

        searchOverlay.classList.remove("open");

        if (searchInput) {
            searchInput.value = "";
        }

        if (searchResults) {
            searchResults.innerHTML = "";
        }

    });

}


/* =========================================================
   DATOS PARA BUSCADOR
========================================================= */

const searchableContent = [

    {
        title: "Iglesia al Día",
        category: "Noticias",
        url: "#noticias"
    },

    {
        title: "Un café con aroma de fe",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "El Podcast",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "El Youcat te conecta",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "La Voz Líder",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Hagan lo que Él les diga",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Una palabra en 60 segundos",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Fe y vida diaria",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "La Santa Misa",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Kerigma en fuego",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Semilla vocacional",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Cultiva la Fe",
        category: "Programas",
        url: "#programas"
    },

    {
        title: "Historia de la Diócesis",
        category: "Diócesis",
        url: "#diocesis"
    },

    {
        title: "Advocaciones Marianas",
        category: "Diócesis",
        url: "#diocesis"
    },

    {
        title: "Nuestras Parroquias",
        category: "Diócesis",
        url: "#diocesis"
    },

    {
        title: "Quiénes somos",
        category: "Jóvenes Influencers del Señor",
        url: "#quienes-somos"
    },

    {
        title: "Editorial",
        category: "Opinión y reflexión",
        url: "#editorial"
    },

    {
        title: "Videos",
        category: "Videoteca",
        url: "#videos"
    }

];


if (searchInput && searchResults) {

    searchInput.addEventListener("input", () => {

        const query =
            searchInput.value
                .toLowerCase()
                .trim();

        searchResults.innerHTML = "";

        if (!query) {
            return;
        }


        const results =
            searchableContent.filter(item =>

                item.title
                    .toLowerCase()
                    .includes(query)

                ||

                item.category
                    .toLowerCase()
                    .includes(query)

            );


        if (results.length === 0) {

            searchResults.innerHTML = `
                <div class="search-result">
                    <strong>No encontramos resultados</strong>
                    <span>Prueba con otra palabra.</span>
                </div>
            `;

            return;
        }


        results.forEach(item => {

            const result =
                document.createElement("a");

            result.href = item.url;

            result.className =
                "search-result";

            result.innerHTML = `
                <strong>${item.title}</strong>
                <span>${item.category}</span>
            `;

            result.addEventListener("click", () => {

                searchOverlay.classList.remove("open");

                searchInput.value = "";

                searchResults.innerHTML = "";

            });

            searchResults.appendChild(result);

        });

    });

}


/* =========================================================
   ESC PARA CERRAR BUSCADOR
========================================================= */

document.addEventListener("keydown", event => {

    if (
        event.key === "Escape" &&
        searchOverlay &&
        searchOverlay.classList.contains("open")
    ) {

        searchOverlay.classList.remove("open");

    }

});


/* =========================================================
   MODAL DE VIDEOS
========================================================= */

const videoModal =
    document.getElementById("videoModal");

const videoFrame =
    document.getElementById("videoFrame");

const closeVideo =
    document.getElementById("closeVideo");

const playButtons =
    document.querySelectorAll(".play-button");


playButtons.forEach(button => {

    button.addEventListener("click", event => {

        event.preventDefault();
        event.stopPropagation();

        const card =
            button.closest(".program-card");

        if (!card) {
            return;
        }

        const videoURL =
            card.dataset.video;

        if (
            videoURL &&
            videoURL !==
            "https://www.youtube.com/embed/"
        ) {

            videoFrame.src =
                `${videoURL}?autoplay=1`;

        } else {

            videoFrame.src = "";

            alert(
                "Este programa todavía no tiene un video configurado."
            );

            return;

        }

        videoModal.classList.add("open");

    });

});


if (closeVideo) {

    closeVideo.addEventListener("click", () => {

        closeVideoModal();

    });

}


if (videoModal) {

    videoModal.addEventListener("click", event => {

        if (
            event.target === videoModal
        ) {

            closeVideoModal();

        }

    });

}


function closeVideoModal() {

    videoModal.classList.remove("open");

    videoFrame.src = "";

}


/* =========================================================
   ESC PARA CERRAR VIDEO
========================================================= */

document.addEventListener("keydown", event => {

    if (
        event.key === "Escape" &&
        videoModal &&
        videoModal.classList.contains("open")
    ) {

        closeVideoModal();

    }

});


/* =========================================================
   BOTÓN VOLVER ARRIBA
========================================================= */

const backTop =
    document.getElementById("backTop");


window.addEventListener("scroll", () => {

    if (!backTop) {
        return;
    }

    if (window.scrollY > 500) {

        backTop.classList.add("show");

    } else {

        backTop.classList.remove("show");

    }

});


if (backTop) {

    backTop.addEventListener("click", () => {

        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });

    });

}


/* =========================================================
   ANIMACIÓN SUAVE DE TARJETAS
========================================================= */

const animatedElements =
    document.querySelectorAll(
        ".program-card, .news-card, .diocese-card, .parish-card, .team-card, .video-card"
    );


if ("IntersectionObserver" in window) {

    const observer =
        new IntersectionObserver(
            entries => {

                entries.forEach(entry => {

                    if (entry.isIntersecting) {

                        entry.target.style.opacity = "1";
                        entry.target.style.transform =
                            "translateY(0)";

                        observer.unobserve(
                            entry.target
                        );

                    }

                });

            },
            {
                threshold: 0.08
            }
        );


    animatedElements.forEach(element => {

        element.style.opacity = "0";

        element.style.transform =
            "translateY(18px)";

        element.style.transition =
            "opacity .5s ease, transform .5s ease";

        observer.observe(element);

    });

}


/* =========================================================
   CERRAR MENÚ AL CAMBIAR A ESCRITORIO
========================================================= */

window.addEventListener("resize", () => {

    if (
        window.innerWidth > 800 &&
        mainNav
    ) {

        mainNav.classList.remove("open");

        if (menuToggle) {

            const icon =
                menuToggle.querySelector("i");

            if (icon) {

                icon.classList.remove("fa-xmark");
                icon.classList.add("fa-bars");

            }

        }

    }

});


/* =========================================================
   PREVENIR ENLACES "#" VACÍOS
========================================================= */

document.querySelectorAll('a[href="#"]').forEach(link => {

    link.addEventListener("click", event => {

        event.preventDefault();

    });

});


/* =========================================================
   MENSAJE DE INICIO
========================================================= */

console.log(
    "✝ Jóvenes Influencers del Señor | Diócesis de Ocaña"
);

console.log(
    "Sitio preparado para futura integración con Supabase."
);
