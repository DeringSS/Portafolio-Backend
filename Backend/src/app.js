import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import perfilRoutes from './routes/perfil.routes.js';
import educacionCRoutes from './routes/educacionC.routes.js';
import experienciaRoutes from './routes/experiencia.routes.js';
import tecnologiaRoutes from './routes/tecnologia.routes.js';

const app = express();

app.use(cors());
app.use(express.json());

// Rutas
app.use('/api/auth', authRoutes);
app.use('/api/perfil', perfilRoutes);
app.use('/api/educacionC', educacionCRoutes);
app.use('/api/experiencia', experienciaRoutes);
app.use('/api/tecnologia', tecnologiaRoutes);
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

export default app;