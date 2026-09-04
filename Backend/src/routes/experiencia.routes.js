import {Router} from 'express';
import { requireAuth } from '../middleware/auth.middleware.js';
import { 
    getExperienciaController, createExperienciaController, 
    updateExperienciaController, deleteExperienciaController 
} from '../controllers/experiencia.controllers.js';

const router = Router();

router.get('/', getExperienciaController);
router.post('/', requireAuth, createExperienciaController);
router.put('/:id', requireAuth, updateExperienciaController);
router.delete('/:id', requireAuth, deleteExperienciaController);

export default router;