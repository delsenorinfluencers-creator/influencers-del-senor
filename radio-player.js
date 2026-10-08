(function(){
  const STREAM='https://stream.zeno.fm/9wmjjnrd0rsvv';
  if(document.getElementById('jisRadio')) return;
  const el=document.createElement('div'); el.id='jisRadio'; el.className='jis-radio';
  el.innerHTML='<div class="jis-radio-inner"><div class="jis-radio-title"><span class="jis-radio-icon">📻</span><div><b>Influencers del Señor Radio</b><small><i></i> EMISORA VIRTUAL</small></div></div><button id="jisRadioBtn" aria-label="Reproducir radio">▶</button><div class="jis-radio-text"><b>La voz de la evangelización digital</b><span>Señal de audio en vivo</span></div><button id="jisRadioClose" aria-label="Cerrar reproductor">×</button><audio id="jisRadioAudio" preload="none" playsinline></audio></div>';
  document.body.appendChild(el);
  const audio=el.querySelector('#jisRadioAudio'), btn=el.querySelector('#jisRadioBtn'); audio.src=STREAM;
  btn.onclick=async()=>{try{if(audio.paused){await audio.play()}else audio.pause()}catch(e){alert('No fue posible iniciar la emisora. Intenta nuevamente.')}};
  audio.onplaying=()=>{el.classList.add('playing');btn.textContent='❚❚'};
  audio.onpause=()=>{el.classList.remove('playing');btn.textContent='▶'};
  el.querySelector('#jisRadioClose').onclick=()=>{audio.pause();el.classList.add('closed')};
})();
