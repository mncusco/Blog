$ErrorActionPreference='Stop'
$root='C:\Users\marce\.copilot\repos\Blog'
$enc=New-Object System.Text.UTF8Encoding($false)

# ---------- articoli.html ----------
$file=Join-Path $root 'articoli.html'
$c=Get-Content -Raw -LiteralPath $file

# 1) jump: aggiungi link Coaching dopo #analisi (se non già presente)
$jtag='<a href="#analisi">Analisi</a>'
if($c.Contains($jtag)){
  $c=$c.Replace($jtag,$jtag+"`n<a href=`"#coaching`">Coaching</a>`n")
  Write-Output 'articoli.html: link Coaching aggiunto al jump'
}else{
  Write-Output 'articoli.html: jump "#analisi" NON trovato'
}

# 2) sezione categoria Coaching prima di </main>
$close='</main>'
$i=$c.LastIndexOf($close)
if($i -ge 0){
  $section=@'
<section class="category" id="coaching">
<h2>Coaching</h2>
<div class="grid">
<article class="card"><div class="tag">Coaching</div><h3>La trasformazione non nasce dalla velocità, ma dalla profondità.</h3><p>In un mondo che corre sempre, la crescita vera non somiglia a una fuga: è un incontro più lento, più intenso e più genuino con ciò che siamo.</p><a class="read" href="la-trasformazione-non-nasce-dalla-velocita.html">Leggi l'articolo →</a><div class="meta">Coaching · 7 min</div></article>
</div>
</section>

'@
  $c=$c.Substring(0,$i)+$section+$c.Substring($i)
  Write-Output 'articoli.html: sezione categoria Coaching inserita prima di </main>'
}else{
  Write-Output 'articoli.html: </main> NON trovato'
}

[IO.File]::WriteAllText($file,$c,$enc)
Write-Output 'articoli.html salvato (UTF-8 no BOM)'
