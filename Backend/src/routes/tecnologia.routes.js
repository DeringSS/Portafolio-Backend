import {Router} from 'express';
import { requireAuth } from '../middleware/auth.middleware.js';
import { 
    getTecnologiaController, createTecnologiaController, 
    updateTecnologiaController, deleteTecnologiaController 
} from '../controllers/tecnologia.controllers.js';

const router = Router();

router.get('/', getTecnologiaController);
router.post('/', requireAuth, createTecnologiaController);
router.put('/:id', requireAuth, updateTecnologiaController);
router.delete('/:id', requireAuth, deleteTecnologiaController);

export default router;