import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import perfilRoutes from './routes/perfil.routes.js';
import educacionCRoutes from './routes/educacionC.routes.js';

const app = express();

app.use(cors());
app.use(express.json());

// Rutas
app.use('/api/auth', authRoutes);
app.use('/api/perfil', perfilRoutes);
app.use('/api/educacionC', educacionCRoutes);

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

export default app;