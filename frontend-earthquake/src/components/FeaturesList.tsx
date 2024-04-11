// src/components/FeaturesList.tsx

import React, { useState, useEffect } from 'react';
import axios from 'axios';
import AddComment from './AddComment';
import './FeaturesList.css'

const FeaturesList: React.FC = () => {
  const [features, setFeatures] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchFeatures = async () => {
      try {
        const response = await axios.get('http://localhost:3000/api/features');
        setFeatures(response.data.data);
        setLoading(false);
      } catch (error) {
        console.error('Error:', error);
        setLoading(false);
      }
    };

    fetchFeatures();
  }, []);

  if (loading) {
    return <p>Loading...</p>;
  }

  return (
    <div>
      <h1>Eventos Sísmicos</h1>
      <ul className='container'>
        {features.map((feature) => (
          <li key={feature.id} className="box">
            <h2>{feature.attributes.title}</h2>
            <div className='pBox'><p>Magnitud:</p><p>{feature.attributes.magnitude}</p></div>
            <div className='pBox'><p>Lugar:</p><p>{feature.attributes.place}</p></div>
            <div className='pBox'><p>Hora:</p><p>{feature.attributes.time}</p></div>
            <div className='pBox'><p>Tsunami:</p><p>{feature.attributes.tsunami ? 'Yes' : 'No'}</p></div>
            <div className='pBox'><p>Mag Type:</p><p>{feature.attributes.mag_type}</p></div>

            

            {/* <p>Magnitud: {feature.attributes.magnitude}</p>
            <p>Lugar: {feature.attributes.place}</p>
            <p>Hora:  {feature.attributes.time}</p>
            <p>Tsunami: {feature.attributes.tsunami ? 'Yes' : 'No'}</p>
            <p>Mag Type: {feature.attributes.mag_type}</p> */}
            <a href={feature.links.external_url} target="_blank" rel="noopener noreferrer">
              
              <button className='buttonUSGS'>
                <p>USGS</p>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"                  
                >
                  <path
                    
                    
                    d="M14 5l7 7m0 0l-7 7m7-7H3"
                  ></path>
                </svg>
              </button>
            </a>
            <AddComment featureId={feature.id} />
          </li>
        ))}
      </ul>

    </div>
  );
};

export default FeaturesList;
