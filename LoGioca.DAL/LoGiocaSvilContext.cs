using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace LoGioca.DAL.Models
{
    public partial class LoGiocaSvilContext : DbContext
    {
        private readonly IConfiguration _configuration;
        protected readonly string _schemaName;
        protected readonly string _connectionString;

        public LoGiocaSvilContext(DbContextOptions<LoGiocaSvilContext> options, IConfiguration configuration)
            : base(options)
        {
            _configuration = configuration;
            _schemaName = _configuration.GetValue<string>("Schema");
            _connectionString = _configuration.GetValue<string>("ConnectionStrings:LoGiocaConnection");
        }

    }
}
