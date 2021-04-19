using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using LoGioca.DAL.Models;

namespace LoGioca.DAL
{
    public class UnitOfWork : IDisposable
    {
        private LoGiocaSvilContext _context;

        public UnitOfWork(LoGiocaSvilContext context)
        {
            _context = context;
        }

        public LoGiocaSvilContext GetContext()
        {
            return _context;
        }

        private bool disposed = false;

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
    }
}
