const express = require('express');
const session = require('express-session');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const app = express();
const port = 3000;

// Middleware
app.set('view engine', 'ejs');
app.set('views', __dirname + '/public');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: false
}));

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'prime_mart'
});

db.connect(err => {
  if (err) throw err;
  console.log('MySQL connected');
});

// Routes
app.get('/', (req, res) => {
  res.render('index', { session: req.session });
});

app.get('/products', (req, res) => {
  res.render('products', { session: req.session });
});

app.get('/cart', (req, res) => {
  res.render('cart', { session: req.session });
});

app.get('/wishlist', (req, res) => {
  res.render('wishlist', { session: req.session });
});

app.get('/login', (req, res) => {
  res.render('login', { session: req.session });
});

app.get('/register', (req, res) => {
  res.render('register', { session: req.session });
});

app.get('/checkout', (req, res) => {
  res.render('checkout', { session: req.session });
});

app.get('/about', (req, res) => {
  res.render('about', { session: req.session });
});

app.get('/contact', (req, res) => {
  res.render('contact', { session: req.session });
});

app.get('/privacy', (req, res) => {
  res.render('privacy', { session: req.session });
});

app.get('/terms', (req, res) => {
  res.render('terms', { session: req.session });
});

// Add the /shop route
app.get('/shop', (req, res) => {
  res.render('shop', { session: req.session });
});

// Register
app.post('/register', async (req, res) => {
  const { username, email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    db.query('INSERT INTO users (username, email, password) VALUES (?, ?, ?)', 
      [username, email, hashedPassword], 
      (err) => {
        if (err) {
          if (err.code === 'ER_DUP_ENTRY') {
            return res.send('Error: Username or email already exists');
          }
          throw err;
        }
        res.redirect('/login');
      });
  } catch (err) {
    res.send('Error during registration');
  }
});

// Login
app.post('/login', (req, res) => {
  const { email, password } = req.body;
  db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
    if (err || results.length === 0) return res.send('Invalid email or password');
    const match = await bcrypt.compare(password, results[0].password);
    if (match) {
      req.session.user = results[0].username;
      res.redirect('/');
    } else {
      res.send('Invalid email or password');
    }
  });
});

// Logout
app.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/');
});

app.listen(port, () => {
  console.log(`Prime Mart server running at http://localhost:${port}`);
});