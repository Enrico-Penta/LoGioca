using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using LoGioca.DAL.Models;

namespace LoGioca.DAL
{
    public interface IRepository<T> where T : class
    {
        Task<List<T>> GetAllAsync();

        Task<T> GetAsync(params object[] id);

        Task<T> GetAsync(T entity);

        Task<IQueryable<T>> FindAsync(Expression<Func<T, bool>> predicate);

        Task<T> AddAsync(T entity);

        Task<T> UpdateAsync(T entity);

        Task<int> DeleteAsync(long id);

        Task<int> DeleteAsync(T entity);


        List<T> GetAll();

        IQueryable<T> GetAllQueryable();

        T Get(params object[] id);

        T Get(T entity);

        IQueryable<T> Find(Expression<Func<T, bool>> predicate);

        T Add(T entity);

        T Update(T entity);

        int Delete(params object[] id);

        int Delete(T entity);

        UnitOfWork UnitOfWork();
    }

    public abstract class Repository<T> : IRepository<T>, IDisposable where T : class
    {
        public LoGiocaSvilContext _context { get; }

        public Repository(LoGiocaSvilContext context)
        {
            this._context = context;
        }


        #region Async
        public async Task<T> GetAsync(params object[] id)
        {
            var entity = await _context.Set<T>().FindAsync(id);
            _context.Entry(entity).State = EntityState.Detached;

            return entity;
        }

        public async Task<T> GetAsync(T entity)
        {
            var _entity = await _context.Set<T>().FindAsync(entity);
            _context.Entry(_entity).State = EntityState.Detached;

            return _entity;
        }

        public async Task<List<T>> GetAllAsync()
        {
            return await _context.Set<T>()
                                .AsNoTracking()
                                .ToListAsync();
        }

        public abstract Task<IQueryable<T>> FindAsync(Expression<Func<T, bool>> predicate);

        public async Task<T> AddAsync(T entity)
        {
            _context.Set<T>().Add(entity);
            var res = await _context.SaveChangesAsync();
            if (res <= 0)
                return null;

            return entity;
        }


        public async Task<T> UpdateAsync(T entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            var res = await _context.SaveChangesAsync();

            if (res <= 0)
                return null;

            return entity;
        }


        public async Task<int> DeleteAsync(T entity)
        {
            if (entity == null)
            {
                return 0;
            }

            _context.Set<T>().Remove(entity);
            return await _context.SaveChangesAsync();
        }

        public async Task<int> DeleteAsync(long id)
        {
            var entity = await _context.FindAsync<T>(id);

            if (entity == null)
            {
                return 0;
            }

            _context.Set<T>().Remove(entity);
            return await _context.SaveChangesAsync();
        }

        #endregion

        #region Sync

        public virtual T Get(params object[] id)
        {
            var entity = _context.Set<T>().Find(id);
            if (entity == null)
                return null;

            _context.Entry(entity).State = EntityState.Detached;

            return entity;
        }

        public List<T> GetAll()
        {
            return _context.Set<T>()
                .AsNoTracking()
                .ToList();
        }

        public IQueryable<T> GetAllQueryable()
        {
            return _context.Set<T>()
                .AsNoTracking();
        }

        public T Get(T entity)
        {
            var _entity = _context.Set<T>().Find(entity);
            _context.Entry(_entity).State = EntityState.Detached;

            return _entity;
        }

        public abstract IQueryable<T> Find(Expression<Func<T, bool>> predicate);

        public T Add(T entity)
        {
            _context.Set<T>().Add(entity);
            var res = _context.SaveChanges();
            if (res <= 0)
                return null;

            return entity;
        }

        public T Update(T entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            var res = _context.SaveChanges();

            if (res <= 0)
                return null;

            return entity;
        }


        public int Delete(params object[] id)
        {
            var entity = _context.Find<T>(id);

            if (entity == null)
            {
                return 0;
            }

            _context.Set<T>().Remove(entity);
            return _context.SaveChanges();
        }

        public int Delete(T entity)
        {
            if (entity == null)
            {
                return 0;
            }

            _context.Set<T>().Remove(entity);
            return _context.SaveChanges();
        }

        #endregion


        public UnitOfWork UnitOfWork()
        {
            return new UnitOfWork(_context);
        }

        #region IDisposable Support
        protected bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    _context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}
