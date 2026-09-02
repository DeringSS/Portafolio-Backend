import { Router } from 'express';
import { getPerfilPublico, editarPerfil } from '../controllers/perfil.controllers.js';

import { requireAuth } from '../middleware/auth.middleware.js';

const router = Router();

router.get('/', getPerfilPublico);
router.put('/', requireAuth, editarPerfil)

export default router;