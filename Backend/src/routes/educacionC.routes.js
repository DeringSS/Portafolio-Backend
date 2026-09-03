import {Router} from 'express';
import { getEducacionC } from '../controllers/educacionC.controllers.js';

const router = Router();

router.get('/', getEducacionC);

export default router;
