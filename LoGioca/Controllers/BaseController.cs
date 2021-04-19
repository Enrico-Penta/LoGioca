using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using LoGioca.Models;
using Microsoft.AspNetCore.Http;
using LoGioca.Utility;

namespace LoGioca.Controllers
{
    public class BaseController : Controller
    {
        public IConfiguration _config;
        protected Azione _Azione;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public SessionManager _sessionManager { get; set; }
        public BaseController(IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
            _config = configuration;
            _sessionManager = new SessionManager(_httpContextAccessor);

        }

        // FUNZIONE PER PRENDERE L'AMBIENTE E LA VERSIO\NE DEL PROGRAMMA
        protected async Task<VersioneAmbiente> GetAmbienteVersione()
        {
            var versioneAmbiente = new VersioneAmbiente
            {
                Ambiente = _config.GetValue<string>("Info:Ambiente") ?? "",
                Versione = _config.GetValue<string>("Info:Versione") ?? "",
                Descrizione = _config.GetValue<string>("Info:Descrizione") ?? ""
            };

            return versioneAmbiente;
        }

    }
}