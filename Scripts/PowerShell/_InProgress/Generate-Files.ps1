

do {
    New-Item -ItemType Directory -Path .\FileStaging\
    Set-Location .\FileStaging\
# Build a random File size
    $size = Get-Random -Minimum 10000 -Maximum 2200000

# Build a random file extention
    $ext = get-random (".ps1",".exe",".bat",".txt",".com",".doc",".docx",".ppt",".pptx",".xls",".xlsx")

# Create a random file name from a list
    $wordlist = ("Buffacross","Antelow","Vultath","Vulturig","Fieron","Doomwing","Magmadillo","Magmodile","Hippony","Jackalfa","Falcoreon","Pigeozel","Donkuzz","Rhinocoal","Quickray","Shelpecker","Sandelope","Herbosaur","Papayak","Ingotter","Giraceon","Albasaur","Scorpash","Rhineaf","Ramvark","Chillbil","Blastowary","Rampephant","Baboom","Gnuke","Wolvenium","Buffactric","Pengena","Alligith","Stunhawk","Venoron","Ninjatee","Goldeleon","Octopine","Snailment","Salamatric","Draly","Leopair","Alligig","Gladiaking","Quickkey","Sandos","Bonida","Monkeye","Crocodoom","Salatuff","Pigeotar","Lobstix","Buffena","Fierray","Hypemingo","Hypoyote","Gladitar","Twilightingale","Quaileaf","Crotic","Toanite","Cobruna","Armadeaf","Steelron","Magmahog","Doomitar","Spinacle","Sardeeno","Mockroach","Shazel","Salamamire","Badgeaf","Flameo","Venohawk","Goleking","Voltarak","Terrapi","Koalava","Quailynx","Kangabuff","Hipporos","Falceon","Chimpanzotto","Electririlla","Venoguin","Fluffopus","Megatee","Groundog","Apricode","Flamibite","Elalix","Mantig","Chickepi","Fluhawk","Spiray","Voltalo","Blastey","Elandroid","Sharcade","Bislash","Wallanyte","Alligaza","Dragoke","Bonepecker","Spiron","Growopotamus","Charamel","Berriot","Rabbyte","Dratric","Dramish","Armadepi","Crocodaid","Skelepecker","Charzelle","Stunoda","Megatee","Brawnkey","Walruse","Toadrill","Koanyte","Scorpius","Kangareon","Quidine","Whirltile","Glaceleon","Slowacuda","Porcupike","Gnuke","Porcupip","Koapod","Flamotto","Leopig","Whirlraffe","Chillnea","Terrida","Wintoda","Clovertex","Tsardine","Albamire","Buffadily","Panthygon","Lemeon","Chillphin","Chillboon","Herbela","Herbium","Jellyfists","Mermantis","Crocomire","Scorpily","Oystoom","Flamotto","Fierzelle","Golepie","Doomatee","Carnander","Hippony","Pandaze","Rhinostar","Shatar","Chickoke","Parrette","Stunwhale","Quilquito","Electrora","Silvering","Falcondor","Quailynx","Salactric","Chameplume","Pengops","Falcory","Venofly","Voltbat","Bonarak","Kyneon","Aquail","Bambinosaur","Manabite","Gazebuff","Lemord","Mantord","Gladiaroach","Steeldine","Ninjowary","Kynibou","Ghostrich","Stingrage","Catebyss","Dramite","Koalaza","Scorpola","Ashtopus","Doommeleon","Rampican","Deweton","Ghostrich","Pigloo","Rhinoron","Armapet","Termory","Lobstops","Fiepion","Voltling","Ninjatross","Ninjabura","Parriot","Mockroach","Gazelax","Swabuff","Mosqung","Donkow","Stunbug","Ghopie","Blastoda","Electribia","Frogre","Camouse","Octopip","Hippobite","Dracash","Chimpanzuno","Hypetopus","Quilphin","Waring","Burnowary","Turtoy","Falcondor","Bibuff","Shaplume","Kangaruno","Panthite","Groboon","Quilfly","Steelaros","Starican","Antethereal","Lobsteroid","Coyozel","Chimpareon","Caterpotto","Komodygon","Ashmeleon","Elesel","Carnaros","Kynuar","Vaporc","Viperk","Cropix","Crocotar","Koaloom","Octopix","Chillraffe","Blastwhale","Meltossum","Kinetowary","Dinoscythe","Wispider","Falcomite","Wolvetric","Crocodeon","Cobrita","Hypesel","Quipecker","Doomodo","Slowey","Propelican","Camouse","Flados","Coyoplume","Komodius","Termoal","Elechopper","Elecpion","Slowypus","Rockupine","Sardeeno","Riotter","Jaguapix","Alligareon","Chickeo","Jagath","Ramphin","Venoguin","Rockyte","Chillida","Raccoconut","Mascotton","Toaceon","Koatar","Dracoss","Mantola","Slowbil","Skelebug","Rockoceros","Whirlopotamus","Ponymph","Magnettle" )

    $fileName = Get-Random $wordlist

    fsutil file createnew $fileName$ext $size


 #Send file to fileSver and delete original
Move-Item * -Destination \\filesvr01\


# Sleep script
    $SleepTime = get-random -Minimum 30 -Maximum 150

    Start-Sleep -Seconds $SleepTime

    set-Location ..
    Remove-Item -Path .\FileStaging\ -Recurse -Force
    
} while ($true) #close Do Loop





