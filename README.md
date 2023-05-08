# scripts

usb debug acik olmasi gerekiyor
bridge yi vpn olarak baglaniliyor vpn konfigurasyonlarini apk direk yapiyor (sadece vpn icin degil server da ki adb ile android de ki adb nin haberlesmesi icin gerekli adb forward, reverse komutlarini calistirmasi icin)

detayli kullanim yazmak istemiyorum cunku program assagidaki repoda anlatilmis

ilk kurulumda scriptteki en son satirda programi calistiriyor tekrar calistirmak istediginizde en son satiri calistirmaniz yeterli

kablosuz olarakta usb debug yapilabiliyor bu yuzden kablosuz olarakta ayni seyler gecerli

tek adb server a birden fazla cihaz eklenebiliyor manuel belirtmek isterseniz gnirehtet [ip:port | serialid]

bu sadece setup scriptidir
gnirehtetin java versiyonu icin brewsiz java kurup calistirir

gnirehtetin rust versiyonu 650mb civari oldugu icin indirmesi haric 30dk suruyor brew reposunda mevcuttur
brewli javada derlemesi uzun suruyodu oyuzden derlenmis source java 8u331 indirip hizli sekilde kuruluyor

scriptin indirdigi dosyalar adbtools java ve kaynagi assagidaki link olan programimiz

https://github.com/Genymobile/gnirehtet
