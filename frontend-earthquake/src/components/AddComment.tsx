import React, { useState } from 'react';
import axios from 'axios';
import './AddComment.css'

interface AddCommentProps {
  featureId: string;
}

const AddComment: React.FC<AddCommentProps> = ({ featureId }) => {
  const [body, setBody] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!body.trim()) {
      setError('El cuerpo del comentario no puede estar en blanco');
      return;
    }

    try {
      await axios.post(`http://localhost:3000/api/features/${featureId}/comments`, {
        body,
      });
      setBody('');
      setError('');
      alert('Comentario añadido correctamente');
    } catch (err) {
      setError('Error al añadir comentario');
    }
  };

  return (
    <div className='divBox'>
      <h3>Añadir Comentario</h3>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      <form onSubmit={handleSubmit} >
        <div className="InputContainer">
          <textarea
            value={body}
            onChange={(e) => setBody(e.target.value)}
            placeholder="Agregue un comentario"            
            className="input"
            
          />
        </div>                
        <button className='buttonForm' type="submit">Añadir</button>
      </form>
    </div>
  );
};

export default AddComment;
