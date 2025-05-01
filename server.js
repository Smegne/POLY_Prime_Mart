const express = require('express');
const session = require('express-session');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const port = 3800;

// Middleware
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'public')); // Set views directory to 'public'
app.use(express.static('public')); // Serve static files from 'public'
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json()); // Parse JSON for API endpoints
app.use(session({
  secret: 'your-secret-key', // Replace with a secure key
  resave: false,
  saveUninitialized: false,
  cookie: { secure: false } // Set to true if using HTTPS
}));

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // Update with your MySQL password if needed
  database: 'prime_mart'
});

db.connect(err => {
  if (err) {
    console.error('MySQL connection failed:', err);
    process.exit(1);
  }
  console.log('MySQL connected');
});

// Create Tables if they don't exist
// Users Table
db.query(`
  CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`, err => {
  if (err) console.error('Error creating users table:', err);
});

// Products Table
db.query(`
  CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL  NOT NULL,
    description TEXT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    discount INT DEFAULT 0,
    stock INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    set_in ENUM('latest', 'bestselling') NOT NULL DEFAULT 'latest',
    show_in ENUM('home page', 'shop page') NOT NULL DEFAULT 'shop page',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`, err => {
  if (err) console.error('Error creating products table:', err);
});

// Orders Table
db.query(`
  CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
  )
`, err => {
  if (err) console.error('Error creating orders table:', err);
});

// Support Tickets Table
db.query(`
  CREATE TABLE IF NOT EXISTS support_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    subject VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('open', 'closed') DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
  )
`, err => {
  if (err) console.error('Error creating support_tickets table:', err);
});

// Promotions Table
db.query(`
  CREATE TABLE IF NOT EXISTS promotions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    discount_percentage INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`, err => {
  if (err) console.error('Error creating promotions table:', err);
});

// Banners Table
db.query(`
  CREATE TABLE IF NOT EXISTS banners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    link VARCHAR(255),
    alt_text VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`, err => {
  if (err) console.error('Error creating banners table:', err);
});

// Roles Table
db.query(`
  CREATE TABLE IF NOT EXISTS roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  )
`, err => {
  if (err) console.error('Error creating roles table:', err);
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
  // Fetch products for the homepage (show_in = 'home page')
  db.query("SELECT * FROM products WHERE show_in = 'home page' ORDER BY id DESC", (err, products) => {
    if (err) {
      console.error('Error fetching products for homepage:', err);
      return res.status(500).send('Server error');
    }
    res.render('index', { session: req.session, products });
  });
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
  // Fetch products for the shop page (show_in = 'shop page')
  db.query("SELECT * FROM products WHERE show_in = 'shop page' ORDER BY id DESC", (err, products) => {
    if (err) {
      console.error('Error fetching products for shop page:', err);
      return res.status(500).send('Server error');
    }
    res.render('shop', { session: req.session, products });
  });
});

app.get('/my-account', isAuthenticated, (req, res) => {
  res.render('my-account', { session: req.session });
});

app.get('/order-complete', (req, res) => {
  res.render('order-complete', { session: req.session });
});

// Admin Dashboard Route (Protected)
app.get('/admin-dashboard', isAuthenticated, (req, res) => {
  db.query("SELECT * FROM products ORDER BY id DESC", (err, products) => {
    if (err) {
      console.error('Error fetching products for admin dashboard:', err);
      return res.status(500).send('Server error');
    }
    res.render('admin-dashboard', { session: req.session, products });
  });
});

// Register
app.post('/register', async (req, res) => {
  const { username, email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    db.query(
      'INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
      [username, email, hashedPassword],
      (err) => {
        if (err) {
          if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).send('Error: Username or email already exists');
          }
          console.error('Error registering user:', err);
          return res.status(500).send('Error during registration');
        }
        res.redirect('/login');
      }
    );
  } catch (err) {
    console.error('Error hashing password:', err);
    res.status(500).send('Server error');
  }
});

// Login
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Validate input
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }

    // Query user
    db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
      if (err) {
        console.error('Error fetching user:', err);
        return res.status(500).json({ error: 'Server error' });
      }

      if (results.length === 0) {
        return res.status(401).json({ error: 'Invalid email or password' });
      }

      const user = results[0];
      const match = await bcrypt.compare(password, user.password);

      if (!match) {
        return res.status(401).json({ error: 'Invalid email or password' });
      }

      // Set session
      req.session.user = {
        id: user.id,
        username: user.username
      };

      // Return success response
      res.status(200).json({ message: 'Login successful' });
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Logout
app.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.error('Error logging out:', err);
      return res.status(500).send('Server error');
    }
    res.redirect('/');
  });
});

// Admin Dashboard API Endpoints
// Product Endpoints
app.get('/api/products', (req, res) => {
  db.query("SELECT * FROM products ORDER BY id DESC", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

app.post('/api/products', (req, res) => {
  const { title, description, image_url, price, discount, stock, category, set_in, show_in } = req.body;

  // Validate required fields
  if (!title || !description || !image_url || !price || !stock || !category || !set_in || !show_in) {
    return res.status(400).json({ error: 'All required fields must be provided' });
  }

  // Validate set_in and show_in values
  const validSetIn = ['latest', 'bestselling'];
  const validShowIn = ['home page', 'shop page'];
  if (!validSetIn.includes(set_in) || !validShowIn.includes(show_in)) {
    return res.status(400).json({ error: 'Invalid set_in or show_in value' });
  }

  db.query(
    "INSERT INTO products (title, description, image_url, price, discount, stock, category, set_in, show_in) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
    [title, description, image_url, price, discount || 0, stock, category, set_in, show_in],
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