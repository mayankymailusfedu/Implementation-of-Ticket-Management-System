using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(StaffTicket.Startup))]
namespace StaffTicket
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
