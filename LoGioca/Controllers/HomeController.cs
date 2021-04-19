using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using LoGioca.Models;
using Microsoft.Extensions.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using LoGioca.DAL.Models;
using LoGioca.BLL.Service;
using LoGioca.BLL.DTOs;
using Microsoft.AspNetCore.Http;

namespace LoGioca.Controllers
{
    public class HomeController : BaseController
    {
        private readonly IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO> _giocatoriDisponibiliServiceRepository;
        public HomeController(IConfiguration configuration,
            IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO> giocatoriDisponibiliServiceRepository,
            IHttpContextAccessor httpContextAccessor
            ) : base(configuration, httpContextAccessor)
        {

            IConfiguration _config = configuration;
            _giocatoriDisponibiliServiceRepository = giocatoriDisponibiliServiceRepository;
        }

        public async Task<IActionResult> Index()
        {
            var versioneAmbiente = await GetAmbienteVersione();
            return View();
        }
        public async Task<IActionResult> PartialGetGiocatori()
        {
            var giocatori = await Task.Run(() =>
            {
                return _giocatoriDisponibiliServiceRepository.GetAllGiocatoriDisponibili();
            });
            return PartialView("_Giocatori", giocatori);
        }

        public async Task<IActionResult> PartialIndex()
        {
            return PartialView("Index");
        }

        public async Task<IActionResult> PartialCalendario()
        {

            return PartialView("_Calendario");
        }
    }
}

public class responsMessage
{
    public bool Success { get; set; }
    public string Msg { get; set; }
}

