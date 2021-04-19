using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using LoGioca.BLL.DTOs;

namespace LoGioca.BLL.Service
{
    public interface IGiocatoriDisponibiliServiceRepository<T> : IServiceRepository<T>
    {
        Task<List<GiocatoriDisponibiliDTO>> GetAllGiocatoriDisponibili();
    }
}
