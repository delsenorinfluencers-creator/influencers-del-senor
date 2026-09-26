(function(){
  const C=window.JIS_CONFIG||{};
  const apply=s=>{const S=s||{};document.querySelectorAll('[data-logo]').forEach(e=>e.src=C.logoOverride||S.logo_url||C.logo||'');document.querySelectorAll('[data-site-name]').forEach(e=>e.textContent=S.site_name||C.siteName||'Jóvenes Influencers del Señor');document.querySelectorAll('[data-year]').forEach(e=>e.textContent=new Date().getFullYear());const icon=document.querySelector('link[rel="icon"]');if(icon)icon.href=C.logoOverride||S.logo_url||C.logo||'/favicon.svg';};
  apply({logo_url:C.logo,site_name:C.siteName});
  const b=document.getElementById('menuBtn'),n=document.getElementById('nav');
if(b&&n){
  b.setAttribute('aria-expanded','false');
  b.addEventListener('click',()=>{
    const open=n.classList.toggle('open');
    b.setAttribute('aria-expanded',String(open));
  });
  n.querySelectorAll('.nav-drop-btn').forEach(btn=>{
    btn.addEventListener('click',e=>{
      e.preventDefault();
      const item=btn.closest('.nav-dropdown');
      n.querySelectorAll('.nav-dropdown.open').forEach(other=>{
        if(other!==item){
          other.classList.remove('open');
          const ob=other.querySelector('.nav-drop-btn');
          if(ob)ob.setAttribute('aria-expanded','false');
        }
      });
      const open=item.classList.toggle('open');
      btn.setAttribute('aria-expanded',String(open));
    });
  });
  document.addEventListener('click',e=>{
    if(!n.contains(e.target) && !b.contains(e.target)){
      n.querySelectorAll('.nav-dropdown.open').forEach(item=>{
        item.classList.remove('open');
        const btn=item.querySelector('.nav-drop-btn');
        if(btn)btn.setAttribute('aria-expanded','false');
      });
    }
  });
}
  const path=location.pathname.replace(/\/+$/,'')||'/';document.querySelectorAll('#nav a[data-nav]').forEach(a=>{const p=(a.getAttribute('href')||'').replace(/\/+$/,'')||'/';if(p===path)a.classList.add('active');});
  if(window.SUPABASE_URL&&window.SUPABASE_PUBLISHABLE_KEY&&window.supabase){try{const sb=window.supabase.createClient(window.SUPABASE_URL,window.SUPABASE_PUBLISHABLE_KEY);sb.from('site_settings').select('site_name,logo_url').eq('id',true).maybeSingle().then(r=>{if(!r.error&&r.data)apply(r.data)}).catch(()=>{});}catch(e){}}
})();
window.JIS={
 esc(s){return String(s??'').replace(/[&<>"']/g,m=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]));},
 async supa(){if(!window.supabase)throw new Error('Supabase JS no está cargado.');return window.supabase.createClient(window.SUPABASE_URL,window.SUPABASE_PUBLISHABLE_KEY);},
 youtubeId(url){try{const u=new URL(url);if(u.hostname.includes('youtu.be'))return u.pathname.slice(1);if(u.searchParams.get('v'))return u.searchParams.get('v');const m=u.pathname.match(/\/live\/([^/]+)/);return m?m[1]:null}catch{return null}},
 playerMarkup(row,target){const type=String(row.type||'').toLowerCase(),url=row.url||'',loop=row.loop_url||'',muted=row.muted!==false,t=document.getElementById(target);if(!t)return;if(!url){if(loop)t.innerHTML=`<video controls autoplay loop playsinline ${muted?'muted':''} src="${this.esc(loop)}"></video>`;else t.innerHTML='<div class="live-placeholder">No hay enlace de transmisión configurado.</div>';return}const y=this.youtubeId(url);if(type==='youtube'||y){t.innerHTML=`<iframe src="https://www.youtube-nocookie.com/embed/${this.esc(y)}?autoplay=1&mute=${muted?1:0}&playsinline=1&rel=0"rel=0&controls=0" allow="autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>`;return}if(type==='facebook'){t.innerHTML=`<iframe src="https://www.facebook.com/plugins/video.php?href=${encodeURIComponent(url)}&show_text=false&autoplay=1" allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share" allowfullscreen></iframe>`;return}if(type==='mp4'||type==='webm'||/\.(mp4|webm|ogg)(\?|$)/i.test(url)){t.innerHTML=`<video controls autoplay playsinline ${muted?'muted':''} src="${this.esc(url)}"></video>`;return}if(type==='m3u8'||/\.m3u8(\?|$)/i.test(url)){t.innerHTML=`<video id="jis-hls-video" controls autoplay playsinline ${muted?'muted':''}></video>`;const v=t.querySelector('video');if(v.canPlayType('application/vnd.apple.mpegurl')){v.src=url;v.play().catch(()=>{})}else{const sc=document.createElement('script');sc.src='https://cdn.jsdelivr.net/npm/hls.js@1.5.17';sc.onload=()=>{if(window.Hls&&Hls.isSupported()){const h=new Hls();h.loadSource(url);h.attachMedia(v);h.on(Hls.Events.MANIFEST_PARSED,()=>v.play().catch(()=>{}));}else{t.insertAdjacentHTML('beforeend','<p style="color:#fff;padding:12px">Este navegador no puede reproducir HLS.</p>')}};document.body.appendChild(sc)}return}if(loop){t.innerHTML=`<video controls autoplay loop playsinline ${muted?'muted':''} src="${this.esc(loop)}"></video>`;return}t.innerHTML=`<div class="live-placeholder"><a class="btn" href="${this.esc(url)}" target="_blank" rel="noopener">Abrir transmisión</a></div>`;}
};
