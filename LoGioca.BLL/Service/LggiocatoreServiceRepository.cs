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
    public class LggiocatoreServiceRepository : ILggiocatoreServiceRepository<LggiocatoreDTO>
    {
        private readonly ILggiocatoreRepository<Lggiocatore> _LggiocatoreRepository;
        public LggiocatoreServiceRepository(ILggiocatoreRepository<Lggiocatore> LggiocatoreRepository)
        {
            _LggiocatoreRepository = LggiocatoreRepository;
        }
        public async Task<List<LggiocatoreDTO>> GetAllGiocatori()
        {
            throw new NotImplementedException();
        }

        public LggiocatoreDTO Add(LggiocatoreDTO offerta)
        {
            throw new NotImplementedException();
        }

        public int Delete(long id)
        {
            throw new NotImplementedException();
        }


        public LggiocatoreDTO GetById(long? id)
        {
            throw new NotImplementedException();
        }

        public LggiocatoreDTO Update(LggiocatoreDTO offerta)
        {
            throw new NotImplementedException();
        }

        public List<LggiocatoreDTO> GetAll()
        {
            throw new NotImplementedException();
        }
    }
}
