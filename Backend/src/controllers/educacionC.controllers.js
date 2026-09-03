import {obtenerEducacionC} from '../services/educacionC.services.js';

export async function getEducacionC(req, res) {
    try {
        const educacionC = await obtenerEducacionC();
        return res.status(200).json(educacionC);
    } catch (error) {
        return res.status(500).json({ error: 'No se pudo obtener la educación complementaria' });
    }
}