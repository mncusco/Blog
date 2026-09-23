$ErrorActionPreference='Stop'
$root=Split-Path -Parent $MyInvocation.MyCommand.Definition
$file=Join-Path $root 'articoli.html'
$c=Get-Content -Raw -LiteralPath $file

# 1) aggiungi link Coaching nel jump (prima di #analisi)
$jet=[regex]::Match($c,'<a href="#analisi">Analisi</a>')
if($jet.Success){
  $c=$c.Replace($jet.Value,"`n<a href=`"#analisi`">Analisi</a>`n<a href=`"#coaching`">Coaching</a>`n")
  Write-Output 'jump: aggiunto link Coaching'
}else{
  Write-Output 'jump: marcatore #analisi NON trovato'
}

# 2) aggiungi nuova sezione categoria Coaching PRIMA di </main>
$close='</main>'
$i=$c.LastIndexOf($close)
if($i -ge 0){
  $section=@"
<section class="category" id="coaching">
<h2>Coaching</h2>
<div class="grid">
<article class="card"><div class="tag">Coaching</div><h3>La trasformazione non nasce dalla velocità, ma dalla profondità.</h3><p>In un mondo che corre sempre, il movimento non è ancora crescita: servono profondità, ascolto e il coraggio di fermarsi.</p><a class="read" href="la-trasformazione-non-nasce-dalla-velocita.html">Leggi l'articolo →</a><div class="meta">Coaching · Mente</div></article>
</div>
</section>

"@
  $c=$c.Substring(0,$i)+$section+$c.Substring($i)
  Write-Output 'sezione categoria Coaching: inserita'
}

# salva UTF-8 senza BOM
$enc=New-Object System.Text.UTF8Encoding($false)
[IO.File]::WriteAllText($file,$c,$enc)
Write-Output 'articoli.html salvato (UTF-8 no BOM)'
