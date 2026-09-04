import {Router} from 'express';
import { requireAuth } from '../middleware/auth.middleware.js';
import { 
    getEducacionController, createEducacionController, 
    updateEducacionController, deleteEducacionController 
} from '../controllers/educacionC.controllers.js';

const router = Router();

router.get('/', getEducacionController);
router.post('/', requireAuth, createEducacionController);
router.put('/:id', requireAuth, updateEducacionController);
router.delete('/:id', requireAuth, deleteEducacionController);

export default router;
