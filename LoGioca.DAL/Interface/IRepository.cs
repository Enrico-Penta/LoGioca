using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoGioca.DAL
{
    public interface IRepository<T> where T : class
    {
        Task<List<T>> GetAllAsync();

        Task<T> GetAsync(long id);

        Task<T> GetAsync(T entity);

        Task<List<T>> FindAsync(T filtro);

        Task<T> AddAsync(T entity);

        Task<T> UpdateAsync(T entity);

        Task<int> DeleteAsync(long id);

        Task<int> DeleteAsync(T entity);


        List<T> GetAll();

        IQueryable<T> GetAllQueryable();

        T Get(long id);

        T Get(T entity);

        List<T> Find(T filtro);

        T Add(T entity);

        T Update(T entity);

        int Delete(long id);

        int Delete(T entity);

        UnitOfWork UnitOfWork();
    }
}
