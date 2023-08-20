//author: murmurLAB©

const Reset = "\x1b[0m"
const Bright = "\x1b[1m"
const Dim = "\x1b[2m"
const Underscore = "\x1b[4m"
const Blink = "\x1b[5m"
const Reverse = "\x1b[7m"
const Hidden = "\x1b[8m"

const FgBlack = "\x1b[30m"
const FgRed = "\x1b[31m"
const FgGreen = "\x1b[32m"
const FgYellow = "\x1b[33m"
const FgBlue = "\x1b[34m"
const FgMagenta = "\x1b[35m"
const FgCyan = "\x1b[36m"
const FgWhite = "\x1b[37m"
const FgGray = "\x1b[90m"

const BgBlack = "\x1b[40m"
const BgRed = "\x1b[41m"
const BgGreen = "\x1b[42m"
const BgYellow = "\x1b[43m"
const BgBlue = "\x1b[44m"
const BgMagenta = "\x1b[45m"
const BgCyan = "\x1b[46m"
const BgWhite = "\x1b[47m"
const BgGray = "\x1b[100m"


const express = require('express');
const path = require('path');
const fs = require('fs');
const multer = require('multer'); // Multer kütüphanesini ekledik
const app = express();
const os = require("os")

networkInterfaces = os.networkInterfaces();
// console.log(networkInterfaces);

const platform = os.platform();

let os_t;

if (platform === 'win32') {
  os_t = 4;
} else if (platform === 'darwin') {
  os_t = 1;
} else if (platform === 'linux') {
  os_t = 0;
} else {
  console.log('Running on an unknown operating system');
}

let linux_wireless, macos_wired;

try {
  linux_wireless = networkInterfaces["wlp1s0"][0].address;
} catch (e) {
  // console.log(e);
}
try {
  macos_wired = networkInterfaces["en0"][1].address;
} catch (e) {
  // console.log(e);
}

const port = 3131;
const ip = [
  linux_wireless, //linux wireless lan
  macos_wired, //macos wired lan
  "localhost" // local
];

// console.log(macos_wired);

const secret = "v";

const arguments = process.argv.slice(2); // İlk iki argümanı çıkarır (node ve dosya yolu)

// console.log("Girilen argümanlar:", arguments);

const __dirname2 = arguments[0];



const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const dynamicPath = getDynamicPath(req); // Dinamik yol oluşturma işlevi
    cb(null, dynamicPath);
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage }).single('file');

function getDynamicPath(req) {
  // İhtiyaca göre dinamik yol oluşturma işlemini gerçekleştirin
  // Örneğin, istemci tarafından gönderilen bir yol parametresi kullanılabilir
  // Bu işlevin mantığını ihtiyacınıza göre özelleştirin
  console.log(req.body);
  const userDefinedPath = req.body.path || 'default/';
  return userDefinedPath;
}

app.post('/upload', upload, (req, res) => {
  // Dosya yükleme işlemi tamamlandı
  res.send('Dosya yüklendi ve kaydedildi.');
});

// Serve static files
//------------------------------------------------------------------------------------------
app.post('/upload', multer().single('file'), (req, res) => {
  console.log(222222222, req.body.path);
  const userDefinedPath = req.body.path || ''; // Kullanıcı tarafından belirtilen dizin veya varsayılan boş dizin

  const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, path.join(__dirname2, userDefinedPath)); // Dosyaların yükleneceği klasör
    },
    filename: (req, file, cb) => {
      cb(null, file.originalname); // Dosyanın orijinal adını kullanarak yeni dosya adı
    }
  });
  const upload = multer({ storage }).single('file');
  upload(req, res, function (err) {
    console.log(1111111111, req.body.path);
    if (err instanceof multer.MulterError) {
      return res.status(400).json({ error: err.message });
    } else if (err) {
      return res.status(500).json({ error: 'Dosya yüklenirken bir hata oluştu.' });
    }
    res.status(200).send('File uploaded successfully.');
  });
  
  console.log('Uploaded File:', req.file);
  console.log('User Defined Path:', userDefinedPath);

});
//------------------------------------------------------------------------------------------


app.use('/static', (req, res, next) => {
  console.log(req.path);
  const token = req.query.token;

  if (token === secret) {
    express.static(path.join(__dirname2))(req, res, next);
  } else {
    res.status(403).send('Access denied: Invalid token');
  }
});

// Get folder contents
app.get('/list/*', (req, res) => {
  const token = req.query.token;
  const folderPath = req.params[0] || '';
  const fullPath = path.join(__dirname2, folderPath);

  if (token != secret) {
    res.status(403).send('Access denied: Invalid token');
    return;
  }

  fs.readdir(fullPath, (err, items) => {
    if (err) {
      console.error('Error reading directory:', err);
      return res.status(500).json({ error: 'Internal Server Error' });
    }

    const files = [];
    const folders = [];

    items.forEach(item => {
      const itemPath = path.join(fullPath, item);
      const stats = fs.statSync(itemPath);
      if (stats.isFile()) {
        files.push(item);
      } else if (stats.isDirectory()) {
        folders.push(item);
      }
    });

    res.json({ files, folders });
  });
});

// Serve HTML page
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(port, ip[os_t], () => {
  console.log(`\nServer is running on port ${FgGreen}http://${ip[os_t]}:${port}`);
});
