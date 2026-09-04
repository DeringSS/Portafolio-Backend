import {getTecnologiaService} from '../services/tecnologia.services.js';

export async function getTecnologiaController(req, res) {
    try {
        const tecnologia = await getTecnologiaService();
        return res.status(200).json(tecnologia);
    } catch (error) {
        return res.status(500).json({ error: 'No se pudo obtener la tecnología' });
    }
}