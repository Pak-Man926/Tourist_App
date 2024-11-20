package user.app.touristapp;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;


public class ThingsToDoFragment extends Fragment
{

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_places_to_see, container, false);

        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        List<TouristSpot> spots = new ArrayList<>();
        spots.add(new TouristSpot("Salthill Promenade", "A scenic walkway along Galway Bay.", R.drawable.salthill_promenade));
        spots.add(new TouristSpot("Galway Market", "Local crafts and produce market.", R.drawable.galway_market));
        spots.add(new TouristSpot("Connemara National Park", "Stunning natural landscapes and trails..", R.drawable.conemara_park));
        spots.add(new TouristSpot("Kayaking on the River Corrib", "Guided kayaking tours through the city.", R.drawable.river_corib));
        spots.add(new TouristSpot("Wild Atlantic Way Cycling", "A unique cycling trail with breathtaking views.", R.drawable.atlantic_way));
        spots.add(new TouristSpot("Galway Atlantaquaria", "Ireland's largest aquarium with interactive exhibits.", R.drawable.atlantaquaria));


        TouristSpotAdapter adapter = new TouristSpotAdapter(getContext(), spots);
        recyclerView.setAdapter(adapter);

        return view;
    }
}