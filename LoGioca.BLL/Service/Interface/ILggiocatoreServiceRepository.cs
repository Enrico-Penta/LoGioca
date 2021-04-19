using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using LoGioca.BLL.DTOs;

namespace LoGioca.BLL.Service
{
    public interface ILggiocatoreServiceRepository<T> : IServiceRepository<T>
    {
        Task<List<LggiocatoreDTO>> GetAllGiocatori();
    }
}
