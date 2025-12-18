import { Outlet } from 'react-router-dom';
import Header from '../components/Header_ALL/Header_ALL';
import Footer from '../components/Footer/Footer';

export default function MainLayout() {
  return (
    <>
      <Header mostrarNavegacao={true} />
      <Outlet />
      <Footer />
    </>
  );
}