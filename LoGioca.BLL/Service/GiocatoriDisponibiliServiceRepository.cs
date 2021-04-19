using LoGioca.BLL.DTOs;
using System.Linq;
using System.Collections.Generic;
using LoGioca.DAL;
using LoGioca.DAL.Models;
using System;
using System.Threading.Tasks;
using LoGioca.BLL.Service;

namespace PrenotaSala.BLL.Service
{
    public class GiocatoriDisponibiliServiceRepository : IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO>
    {
        private readonly IGiocatoriDisponibiliRepository<GiocatoriDisponibiliVw> _GiocatoriDisponibiliRepository;
        public GiocatoriDisponibiliServiceRepository(IGiocatoriDisponibiliRepository<GiocatoriDisponibiliVw> GiocatoriDisponibiliRepository)
        {
            _GiocatoriDisponibiliRepository = GiocatoriDisponibiliRepository;
        }
        public async Task<List<GiocatoriDisponibiliDTO>> GetAllGiocatoriDisponibili()
        {
            List<GiocatoriDisponibiliVw> giocatori = await _GiocatoriDisponibiliRepository.GetAllAsync();

            return giocatori?.Select(x => new GiocatoriDisponibiliDTO(x)).OrderBy(x => x.Cognome).ToList();
        }

        public GiocatoriDisponibiliDTO Add(GiocatoriDisponibiliDTO offerta)
        {
            throw new NotImplementedException();
        }

        public int Delete(long id)
        {
            throw new NotImplementedException();
        }

        public List<GiocatoriDisponibiliDTO> GetAll()
        {
            throw new NotImplementedException();
        }


        public GiocatoriDisponibiliDTO GetById(long? id)
        {
            throw new NotImplementedException();
        }

        public GiocatoriDisponibiliDTO Update(GiocatoriDisponibiliDTO offerta)
        {
            throw new NotImplementedException();
        }


    }
}
