using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.AzureAD.UI;
using Microsoft.AspNetCore.Authentication;
using LoGioca.DAL;
using LoGioca.DAL.Models;
using LoGioca.BLL.Service;
using LoGioca.BLL.DTOs;
using PrenotaSala.BLL.Service;
using Microsoft.EntityFrameworkCore;
using System;
using System.IO;
using Microsoft.AspNetCore.Localization;
using System.Linq;
using System.Globalization;
using Microsoft.Extensions.Hosting;

namespace LoGioca
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            services.AddAuthentication(AzureADDefaults.AuthenticationScheme)
                .AddAzureAD(options => Configuration.Bind("AzureAd", options));

            services.AddDbContext<LoGiocaSvilContext>(options =>
            options.UseSqlServer(Configuration.GetConnectionString("LoGiocaConnection"),
            sqlServerOptionsAction: sqlOptions =>
            {
                sqlOptions.EnableRetryOnFailure(
                maxRetryCount: 10,
                maxRetryDelay: TimeSpan.FromSeconds(30),
                errorNumbersToAdd: null);
            }),
            ServiceLifetime.Transient);


            services.AddControllersWithViews(options =>
            {
                var policy = new AuthorizationPolicyBuilder()
                    .RequireAuthenticatedUser()
                    .Build();
                options.Filters.Add(new AuthorizeFilter(policy));
            });
            services.AddSingleton(Configuration);
            services.AddHttpContextAccessor();
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(20);
                options.Cookie.HttpOnly = true;
            });
            services.AddRazorPages();

            services.AddSingleton<IConfiguration>(Configuration);
            services.AddHttpContextAccessor();
            //DAL
            services.AddScoped<ILggiocatoreRepository<Lggiocatore>, LggiocatoreRepository>();
            services.AddScoped<ISportRepository<Sport>, SportRepository>();
            services.AddScoped<IGiocatoriDisponibiliRepository<GiocatoriDisponibiliVw>, GiocatoriDisponibiliRepository>();

            //BLL
            services.AddScoped<ILggiocatoreServiceRepository<LggiocatoreDTO>, LggiocatoreServiceRepository>();
            services.AddScoped<ISportServiceRepository<SportDTO>, SportServiceRepository>();
            services.AddScoped<IGiocatoriDisponibiliServiceRepository<GiocatoriDisponibiliDTO>, GiocatoriDisponibiliServiceRepository>();

        }




        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            var di = new DirectoryInfo(Path.Combine(env.WebRootPath, @"lib\cldr-data\main"));
            var supportedCultures = di.GetDirectories().Where(x => x.Name != "root").Select(x => new CultureInfo(x.Name)).ToList();
            app.UseRequestLocalization(new RequestLocalizationOptions
            {
                DefaultRequestCulture = new RequestCulture("it-IT"/*supportedCultures.FirstOrDefault(x => x.Name == "it")*/),
                SupportedCultures = supportedCultures.Where(x => x.Name == "it").ToList(),
                SupportedUICultures = supportedCultures.Where(x => x.Name == "it").ToList()
            });

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseAuthentication();
            app.UseSession();
            app.UseRouting();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
            });

        }
    }
}
