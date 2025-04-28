const express = require('express');
const session = require('express-session');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const path = require('path');
const app = express();
const port = 3800;

// Middleware
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'public')); // Set views directory to 'public'
app.use(express.static('public')); // Serve static files from 'public'
app.use(express.urlencoded({ extended: true }));
app.use(express.json()); // Add this to parse JSON for API endpoints
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: false
}));

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // Update with your MySQL password if needed
  database: 'prime_mart'
});

db.connect(err => {
  if (err) throw err;
  console.log('MySQL connected');
});

// Middleware to check if user is authenticated
const isAuthenticated = (req, res, next) => {
  if (req.session.user) {
    return next();
  }
  res.redirect('/login');
};

// Routes for Frontend Pages
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

app.get('/shop', (req, res) => {
  res.render('shop', { session: req.session });
});

app.get('/my-account', isAuthenticated, (req, res) => {
  res.render('my-account', { session: req.session });
});

app.get('/order-complete', (req, res) => {
  res.render('order-complete', { session: req.session });
});

// Admin Dashboard Route (Protected)
app.get('/admin-dashboard', isAuthenticated, (req, res) => {
  res.render('admin-dashboard', { session: req.session });
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
      req.session.user = {
        id: results[0].id,
        username: results[0].username
      };
      res.redirect('/my-account');
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

// Admin Dashboard API Endpoints
// Product Endpoints
app.get('/api/products', (req, res) => {
  db.query("SELECT * FROM products", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

app.post('/api/products', (req, res) => {
  const { title, price, discount, stock } = req.body;
  db.query(
    "INSERT INTO products (title, price, discount, stock) VALUES (?, ?, ?, ?)",
    [title, price, discount, stock],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ id: result.insertId });
    }
  );
});

app.delete('/api/products/:id', (req, res) => {
  const { id } = req.params;
  db.query("DELETE FROM products WHERE id = ?", [id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ deleted: result.affectedRows });
  });
});

// Order Endpoints
app.get('/api/orders', (req, res) => {
  db.query("SELECT * FROM orders", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

app.put('/api/orders/:id', (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  db.query(
    "UPDATE orders SET status = ? WHERE id = ?",
    [status, id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ updated: result.affectedRows });
    }
  );
});

// User Endpoints
app.get('/api/users', (req, res) => {
  db.query("SELECT id, username, email, status FROM users", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

app.put('/api/users/:id', (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  db.query(
    "UPDATE users SET status = ? WHERE id = ?",
    [status, id],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ updated: result.affectedRows });
    }
  );
});

// Support Tickets Endpoints
app.get('/api/support-tickets', (req, res) => {
  db.query("SELECT * FROM support_tickets", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Promotions Endpoints
app.get('/api/promotions', (req, res) => {
  db.query("SELECT * FROM promotions", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Banners Endpoints
app.get('/api/banners', (req, res) => {
  db.query("SELECT * FROM banners", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Roles Endpoints
app.get('/api/roles', (req, res) => {
  db.query("SELECT * FROM roles", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Sales & Analytics (Mock Data for Now, Replace with Real Queries if Needed)
app.get('/api/sales-analytics', (req, res) => {
  res.json({
    totalSales: 125000,
    totalOrders: 150,
    totalUsers: 320,
    bestSellers: [
      { name: "Adidas Mens Blue Tracksuit", sales: 50 },
      { name: "Nike Mens Red Hoodie", sales: 30 }
    ]
  });
});

// Site Settings (Mock Data for Now, Replace with Real Queries if Needed)
app.get('/api/site-settings', (req, res) => {
  res.json({
    shippingRate: 100,
    taxRate: 18
  });
});

app.put('/api/site-settings', (req, res) => {
  const { shippingRate, taxRate } = req.body;
  res.json({ message: "Settings updated", shippingRate, taxRate });
});

// Start the Server
app.listen(port, () => {
  console.log(`Prime Mart server running at http://localhost:${port}`);
});