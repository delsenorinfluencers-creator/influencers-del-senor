import Header from "@/components/Header";
import Footer from "@/components/Footer";

export default function QuienesSomosPage() {
  return (
    <>
      <Header />
      <main className="section">
        <div className="container">
          <h1>Quiénes somos</h1>
          <div className="card" style={{ marginTop: 24 }}>
            <h2>Jóvenes Influencers del Señor</h2>
            <p>
              Somos una iniciativa de comunicación y evangelización digital
              que busca anunciar a Jesucristo, informar sobre la vida de la
              Iglesia y generar contenidos que acerquen la fe a las nuevas
              generaciones.
            </p>
            <p>
              Aquí agregaremos la historia del proyecto, misión, visión,
              integrantes y el equipo completo.
            </p>
          </div>
        </div>
      </main>
      <Footer />
    </>
  );
}