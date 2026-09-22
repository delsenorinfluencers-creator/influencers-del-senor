(function(){
  const C=window.JIS_CONFIG||{};
  document.querySelectorAll("[data-site-name]").forEach(e=>e.textContent=C.siteName||"Jóvenes Influencers del Señor");
  document.querySelectorAll("[data-logo]").forEach(e=>{e.src=C.logo||""});
  const b=document.getElementById("menuBtn"),n=document.getElementById("nav");
  if(b&&n)b.addEventListener("click",()=>n.classList.toggle("open"));
  document.querySelectorAll("[data-year]").forEach(e=>e.textContent=new Date().getFullYear());
})();