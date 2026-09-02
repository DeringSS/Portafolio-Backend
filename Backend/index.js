import 'dotenv/config';
import app from './src/app.js';
import { testConnection } from './src/config/supabaseClient.js';

const PORT = process.env.PORT || 4000;

async function startServer() {
  try {
    await testConnection();
    console.log('✅ Conexión a la base de datos establecida correctamente');

    app.listen(PORT, () => {
      console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
    });
  } catch (error) {
    console.error('❌ Error al conectar con la base de datos:', error.message);
    process.exit(1);
  }
}

startServer();