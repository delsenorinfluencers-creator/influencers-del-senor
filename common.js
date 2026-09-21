const { createClient } = window.supabase;
const sb = createClient(APP_CONFIG.SUPABASE_URL, APP_CONFIG.SUPABASE_PUBLISHABLE_KEY);

function esc(v="") {
  return String(v).replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;")
    .replaceAll('"',"&quot;").replaceAll("'","&#039;");
}

function youtubeId(url="") {
  try {
    const u = new URL(url);
    if (u.hostname.includes("youtu.be")) return u.pathname.slice(1).split("/")[0];
    if (u.hostname.includes("youtube.com")) {
      if (u.pathname === "/watch") return u.searchParams.get("v");
      if (u.pathname.startsWith("/embed/")) return u.pathname.split("/embed/")[1].split("/")[0];
      if (u.pathname.startsWith("/shorts/")) return u.pathname.split("/shorts/")[1].split("/")[0];
    }
  } catch(e) {}
  return null;
}

function videoHtml(url, type) {
  if (!url) return `<div class="video-placeholder">🎥 Video próximamente</div>`;
  if (type === "youtube") {
    const id = youtubeId(url);
    if (id) return `<div class="video-wrap"><iframe src="https://www.youtube.com/embed/${encodeURIComponent(id)}" title="Video" loading="lazy" allowfullscreen></iframe></div>`;
  }
  return `<a class="facebook-video" target="_blank" rel="noopener" href="${esc(url)}">▶ Ver video</a>`;
}

async function currentUser() {
  const {data:{user}} = await sb.auth.getUser();
  return user;
}
