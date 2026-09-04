import {getTecnologiaModel} from '../models/tecnologia.models.js';

export async function getTecnologiaService() {
    const tecnologia = await getTecnologiaModel();
    return tecnologia;
}