(function(){
 const STREAM='https://stream.zeno.fm/9wmjjnrd0rsvv';
 if(document.getElementById('jis-radio-dock'))return;
 const wrap=document.createElement('aside');wrap.id='jis-radio-dock';wrap.innerHTML='<div class="jis-radio-dock-inner"><img src="https://i.ibb.co/hF3t07Lt/IMG-7484.png" alt="Logo Influencers del Señor"><div class="jis-radio-info"><strong>Emisora Online</strong><span>Influencers del Señor · Radio en vivo</span></div><button type="button" id="jis-radio-toggle" aria-label="Reproducir emisora">▶</button><button type="button" id="jis-radio-hide" aria-label="Ocultar reproductor">×</button><audio id="jis-radio-audio" preload="none" playsinline></audio></div>';
 document.body.appendChild(wrap);const audio=wrap.querySelector('audio'),play=wrap.querySelector('#jis-radio-toggle');audio.src=STREAM;
 play.addEventListener('click',async()=>{try{if(audio.paused)await audio.play();else audio.pause()}catch(e){alert('No se pudo iniciar la emisora. Comprueba la conexión e inténtalo de nuevo.')}});
 audio.addEventListener('play',()=>{play.textContent='Ⅱ';wrap.classList.add('is-playing')});audio.addEventListener('pause',()=>{play.textContent='▶';wrap.classList.remove('is-playing')});
 wrap.querySelector('#jis-radio-hide').addEventListener('click',()=>wrap.classList.add('is-hidden'));
})();