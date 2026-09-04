import {Router} from 'express';
import { getTecnologiaController } from '../controllers/tecnologia.controllers.js';

const router = Router();

router.get('/', getTecnologiaController);

export default router;