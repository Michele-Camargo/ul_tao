import java.util.ArrayList;

public class VariableControl {
  private ArrayList<Variable> contvar;

  public VariableControl() {
    contvar = new ArrayList<Variable>();
  }

  public boolean added(Variable v) {
    for (int i = 0; i < contvar.size(); i++) {
      if ((contvar.get(i).getName().equals(v.getName())) && (contvar.get(i).getScope() == v.getScope()))
        return false;
    }
    contvar.add(v);
    return true;
  }

  public Variable search(String name) {
    for (int i = contvar.size() - 1; i >= 0; i--) {
      if (contvar.get(i).getName().equals(name))
        return contvar.get(i);
    }
    return null;
  }

  public boolean jaExiste(String nome) {
    for (int i = contvar.size() - 1; i >= 0; i--) {
      if (contvar.get(i).getName().equals(nome))
        return true;
    }
    return false;
  }

  public void print() {
    for (int i = 0; i < contvar.size(); i++) {
      contvar.get(i).print();
      System.out.println("\n\n");
    }
  }

}
