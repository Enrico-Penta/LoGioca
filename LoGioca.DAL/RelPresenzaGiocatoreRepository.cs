using Microsoft.EntityFrameworkCore;
using LoGioca.DAL.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using LoGioca.DAL;
using System.Transactions;
using System.Linq.Expressions;

namespace LoGioca.DAL
{
    public class RelPresenzaGiocatoreRepository : Repository<RelPresenzaGiocatore>, IRelPresenzaGiocatoreRepository<RelPresenzaGiocatore>
    {

        public RelPresenzaGiocatoreRepository(LoGiocaSvilContext context) : base(context)
        {

        }

        public override IQueryable<RelPresenzaGiocatore> Find(Expression<Func<RelPresenzaGiocatore, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public override Task<IQueryable<RelPresenzaGiocatore>> FindAsync(Expression<Func<RelPresenzaGiocatore, bool>> predicate)
        {
            throw new NotImplementedException();
        }
    }
}
