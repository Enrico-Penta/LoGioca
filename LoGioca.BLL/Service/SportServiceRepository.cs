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
    public class SportServiceRepository : ISportServiceRepository<SportDTO>
    {
        private readonly ISportRepository<Sport> _sportRepository;
        public SportServiceRepository(ISportRepository<Sport> SportRepository)
        {
            _sportRepository = SportRepository;
        }
        public List<SportDTO> GetAll()
        {
            var sport = _sportRepository.GetAll();

            return sport?.Select(x => new SportDTO(x)).OrderBy(x => x.Descrizione).ToList();
        }

        public SportDTO Add(SportDTO offerta)
        {
            throw new NotImplementedException();
        }

        public int Delete(long id)
        {
            throw new NotImplementedException();
        }

        public SportDTO GetById(long? id)
        {
            throw new NotImplementedException();
        }

        public SportDTO Update(SportDTO offerta)
        {
            throw new NotImplementedException();
        }
    }
}
