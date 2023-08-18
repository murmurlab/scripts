const express = require('express');
const path = require('path');
const fs = require('fs');
const multer = require('multer'); // Multer kütüphanesini ekledik
const app = express();
const os = require('os');

const networkInterfaces = os.networkInterfaces();
const ipAddress = networkInterfaces['wlan0'][0].address; // 'wlan0' kısmını bağlı olduğunuz ağ arabirimine göre güncelleyin

console.log(ipAddress);

const port = 3131;
const ip = [
  ipAddress,
  "10.12.17.5",
  "10.19.14.82",
  "localhost"
];
const secret = "v";
const __dirname2 = "/Users/ahbasara/goinfre";



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

app.listen(port, ip[0], () => {
  console.log(`Server is running on port ${port}`);
});
