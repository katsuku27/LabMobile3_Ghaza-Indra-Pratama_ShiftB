# prak3

# Tugas Pertemuan 3

Nama : Ghaza Indra Pratama

NIM : H1D022073

Shift Baru: D

# Kode Penting

## 1. LoginPage.dart

### Username and Password Controllers

Digunakan untuk menangkap kredensial login.

```
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
```

### Login Validation

Memeriksa apakah nama pengguna dan kata sandi sudah benar (admin untuk keduanya) dan menavigasi ke Halaman Utama.

```
void _login() {
  if (_usernameController.text == 'admin' && _passwordController.text == 'admin') {
    _saveUsername();
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Username atau Password Salah')),
    );
  }
}

```

### Save Username using SharedPreferences

Menyimpan nama pengguna di penyimpanan lokal sehingga dapat ditampilkan di halaman beranda.

```
void _saveUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', _usernameController.text);
}

```

## 2. HomePage.dart

### Retrieve Username from SharedPreferences

Pada inisialisasi halaman, ini mengambil nama pengguna yang disimpan untuk menampilkan salam yang dipersonalisasi.

```
void _loadUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    username = prefs.getString('username');
  });
}

```

### Toggle Light/Dark Mode

Beralih antara mode terang dan gelap. Fungsi toggleTheme diteruskan dari aplikasi utama.

```
Switch(
  value: widget.isDarkMode,
  onChanged: (value) {
    widget.toggleTheme(value);
  },
  activeTrackColor: Colors.yellow,
  activeColor: Colors.orangeAccent,
)

```

### Side Menu (Drawer) Integration

Termasuk widget Sidemenu untuk memungkinkan navigasi antar halaman melalui menu samping.

```
drawer: const Sidemenu(),

```

## 3. Main.dart

### Initialize App and Load Theme Preference

Aplikasi ini dimulai dengan memuat mode tema yang disimpan (terang/gelap) dari penyimpanan lokal menggunakan SharedPreferences.

```
void _loadTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  });
}

```

### Theme Toggle Logic

Mengalihkan tema aplikasi berdasarkan pilihan pengguna dan menyimpannya ke penyimpanan lokal.

```
void _toggleTheme(bool isDarkMode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _isDarkMode = isDarkMode;
    prefs.setBool('isDarkMode', isDarkMode);
  });
}

```

### Routing Definition

Defines the routes to different pages in the app, including the LoginPage, HomePage, and AboutPage.

```
MaterialApp(
  theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
  initialRoute: '/',
  routes: {
    '/': (context) => const LoginPage(),
    '/home': (context) => HomePage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    '/about': (context) => const AboutPage(),
  },
)

```

## 4. Sidemenu.dart

### Navigation to Home and About Pages

Setiap ubin daftar pada menu samping memungkinkan navigasi ke halaman yang berbeda menggunakan Navigator.pushReplacementNamed.

```
ListTile(
  leading: const Icon(Icons.home),
  title: const Text('Home'),
  onTap: () {
    Navigator.pushReplacementNamed(context, '/home');
  },
),
ListTile(
  leading: const Icon(Icons.info),
  title: const Text('About'),
  onTap: () {
    Navigator.pushReplacementNamed(context, '/about');
  },
),

```

### Logout Functionality

Mengeluarkan pengguna dengan menghapus nama pengguna dari SharedPreferences dan menavigasi kembali ke halaman masuk.

```
void _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');
  Navigator.pushReplacementNamed(context, '/');
}

```

## 5. AboutPage.dart

Ini adalah halaman sederhana yang menyediakan informasi tentang aplikasi. Halaman ini dinavigasi dari menu samping.

```
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: const Center(
        child: Text(
          'This is the About Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

```

## Screenshot

![Lampiran Login(White)](<Login(White).png>)
![Lampiran LoginAlert(White)](<LoginAlert(White).png>)
![Lampiran homepage(White)](<homepage(White).png>)
![Lampiran sidemenu(White)](<sidemenu(White).png>)
![Lampiran about(White)](<about(White).png>)

![Lampiran Login(Black)](<Login(Black).png>)
![Lampiran LoginAlert(Black)](<LoginAlert(Black).png>)
![Lampiran homepage(Black)](<homepage(Black).png>)
![Lampiran sidemenu(Black)](<sidemenu(Black).png>)
![Lampiran about(Black)](<about(Black).png>)
