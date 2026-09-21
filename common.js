(() => {
  const cfg = window.INFLUENCERS_CONFIG || {};
  const $ = (s, r=document) => r.querySelector(s);

  function nav(active="") {
    const links = [
      ["/", "Inicio"],
      ["/iglesia-al-dia/", "Iglesia al día"],
      ["/programas/", "Programas"],
      ["/en-vivo/", "🔴 En vivo"],
      ["/64-datos/", "64 datos históricos"],
      ["/diocesis/", "Diócesis de Ocaña"],
      ["/editorial/", "Editorial"],
      ["/quienes-somos/", "Quiénes somos"],
      ["/admin/", "Administración"]
    ];
    const el = $("#site-nav");
    if (!el) return;
    el.innerHTML = links.map(([href,label]) =>
      `<a class="${active===href ? "active":""}" href="${href}">${label}</a>`).join("");
  }

  function header(active="") {
    const root = document.body;
    const header = document.createElement("header");
    header.className = "site-header";
    header.innerHTML = `
      <div class="container nav-wrap">
        <a class="brand" href="/">
          <img src="${cfg.LOGO}" alt="Jóvenes Influencers del Señor">
          <span>Jóvenes Influencers<br><small>del Señor</small></span>
        </a>
        <nav id="site-nav"></nav>
        <button class="menu-btn" aria-label="Abrir menú">☰</button>
      </div>`;
    root.prepend(header);
    nav(active);
    header.querySelector(".menu-btn").onclick = () => {
      header.querySelector("nav").classList.toggle("open");
    };
  }

  function footer() {
    const f = document.createElement("footer");
    f.innerHTML = `<div class="container footer-grid">
      <div><strong>Jóvenes Influencers del Señor</strong><p>Medio de comunicación católico de la Diócesis de Ocaña.</p></div>
      <div><strong>Secciones</strong><a href="/iglesia-al-dia/">Iglesia al día</a><a href="/programas/">Programas</a><a href="/en-vivo/">Señal en vivo</a></div>
      <div><strong>Información</strong><a href="/diocesis/">Diócesis de Ocaña</a><a href="/quienes-somos/">Quiénes somos</a><a href="/editorial/">Editorial</a></div>
    </div><div class="copyright">© ${new Date().getFullYear()} Jóvenes Influencers del Señor · Evangelizar en el mundo digital</div>`;
    document.body.append(f);
  }

  function youtubeEmbed(url) {
    if (!url) return "";
    let id = "";
    try {
      const u = new URL(url);
      if (u.hostname.includes("youtu.be")) id = u.pathname.slice(1);
      if (u.hostname.includes("youtube.com")) id = u.searchParams.get("v") || u.pathname.split("/").pop();
    } catch {}
    return id ? `<div class="video"><iframe src="https://www.youtube.com/embed/${id}" title="Video de YouTube" allowfullscreen loading="lazy"></iframe></div>` : `<a class="btn" href="${url}" target="_blank" rel="noopener">Ver video</a>`;
  }

  function formatDate(d) {
    if (!d) return "";
    return new Date(d).toLocaleDateString("es-CO", {day:"2-digit", month:"long", year:"numeric"});
  }

  window.App = { header, footer, youtubeEmbed, formatDate, cfg, $ };
})();