using System;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace LoGioca.BLL.Service
{
    public interface IServiceRepository<T>
    {
        List<T> GetAll();
        T GetById(long? id);
        T Update(T offerta);
        T Add(T offerta);
        int Delete(long id);        

    }
}
